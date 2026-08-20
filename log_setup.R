# Minimal run logger for the three pipeline notebooks.
#
# Deliberately dependency-free. This repository is a public replication archive
# with no package management, and log4r / logger / futile.logger would each be one
# more thing a replicator has to install before any notebook runs. Everything here
# is base R.
#
# Usage, in a notebook's setup chunk:
#
#   source("log_setup.R")            # or source(here("log_setup.R"))
#   log_init("CBP_Data_Cleaning")
#
# then anywhere below:
#
#   log_info("read 2014-2016 CBP files")
#   log_dim("cbp_2012_2022", cbp_2012_2022)
#   log_write("cbp_2012_2022.csv")
#   log_done()
#
# One file per notebook, appended across runs, with a banner separating each run.

log_init <- function(name, dir = "logs") {
  if (!dir.exists(dir)) dir.create(dir, recursive = TRUE)
  path <- file.path(dir, paste0(name, ".log"))
  options(pipeline_log_name = name, pipeline_log_path = path,
          pipeline_log_start = Sys.time())

  con <- file(path, open = "at")
  on.exit(close(con))
  writeLines(c(
    strrep("=", 78),
    sprintf("run started : %s", format(Sys.time(), "%Y-%m-%d %H:%M:%S")),
    sprintf("notebook    : %s", name),
    sprintf("R version   : %s", getRversion()),
    sprintf("platform    : %s", R.version$platform),
    sprintf("working dir : %s", getwd()),
    strrep("=", 78)
  ), con)

  message("logging to ", normalizePath(path, winslash = "/"))
  invisible(path)
}

log_msg <- function(..., level = "INFO") {
  path <- getOption("pipeline_log_path")
  if (is.null(path)) stop("log_init() has not been called in this session")

  line <- sprintf("%s [%-5s] %s",
                  format(Sys.time(), "%Y-%m-%d %H:%M:%S"), level,
                  paste0(...))
  con <- file(path, open = "at")
  on.exit(close(con))
  writeLines(line, con)
  message(line)
  invisible(line)
}

log_info  <- function(...) log_msg(..., level = "INFO")
log_warn  <- function(...) log_msg(..., level = "WARN")
log_error <- function(...) log_msg(..., level = "ERROR")

# Record the shape of a table right after it is built. Row counts are the thing
# that silently changes when a merge or filter goes wrong, so they are worth
# having on disk after the session is gone.
log_dim <- function(label, x) {
  log_info(sprintf("%-28s %s rows x %s cols", paste0(label, ":"),
                   format(nrow(x), big.mark = ","), ncol(x)))
}

# Record a file that was just written, with its size, so a stale intermediate is
# recognisable from the log alone.
log_write <- function(path) {
  size <- if (file.exists(path)) {
    sprintf("%.1f MB", file.info(path)$size / 1024^2)
  } else {
    "MISSING"
  }
  log_info(sprintf("wrote %s (%s)", path, size))
}

log_done <- function() {
  started <- getOption("pipeline_log_start")
  elapsed <- if (is.null(started)) NA else
    round(as.numeric(difftime(Sys.time(), started, units = "mins")), 1)
  log_info(sprintf("run finished (%s minutes)", elapsed))
  invisible(NULL)
}
