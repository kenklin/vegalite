#' Cell aesthetics
#'
#' At its core, a Vega-Lite specification describes a single plot. This function
#' works to format those cells with all of the options avaiable under
#' \href{https://vega.github.io/vega-lite/docs/config.html#cell-config}{config.cell.*}
#' When a facet channel is added, the visualization is faceted into a trellis
#' plot, which contains multiple plots. Each plot in either a single plot or a
#' trellis plot is called a cell. Cell configuration allows us to customize each
#' individual single plot and each plot in a trellis plot. Use facet=TRUE to
#' apply the cell configuration to facets.
#'
#' @param vl Vega-Lite object
#' @param width,height width and height property of the cell configuration determine
#'        the width of a visualization with a continuous x-scale and the height of
#'        a visualization with a continuous y-scale respectively. Visit the
#'        URL in the References section for more information.
#' @param clip \code{FALSE} by default, whether the view should be clipped.
#' @param fill fill color
#' @param fill_opacity \code{0.0}-\code{1.0}
#' @param stroke stroke color
#' @param stroke_opacity \code{0.0}-\code{1.0}
#' @param stroke_width stroke of the width in pixels
#' @param stroke_dash an array of alternating stroke, space lengths for creating
#'        dashed or dotted lines.
#' @param stroke_dash_offset the offset (in pixels) into which to begin drawing with the stroke dash array.
#' @param facet \code{FALSE} by default, set to \code{TRUE} to apply to facets.
#' @encoding UTF-8
#' @references
#'   \href{http://vega.github.io/vega-lite/docs/config.html#cell-config}{Vega-Lite Cell spec}
#' @export

cell_config <- function(vl, width=200, height=200, clip=FALSE, fill=NULL, fill_opacity=NULL,
                        stroke=NULL, stroke_opacity=NULL, stroke_width=NULL,
                        stroke_dash=NULL, stroke_dash_offset=NULL, facet=FALSE) {

  cell <- list()
  if (!is.null(width))              cell$width <- width
  if (!is.null(height))             cell$height <- height
  if (!is.null(clip))               cell$clip <- clip
  if (!is.null(fill))               cell$fill <- fill
  if (!is.null(fill_opacity))       cell$fillOpacity <- fill_opacity
  if (!is.null(stroke))             cell$stroke <- stroke
  if (!is.null(stroke_opacity))     cell$strokeOpacity <- stroke_opacity
  if (!is.null(stroke_width))       cell$strokeWidth <- stroke_width
  if (!is.null(stroke_dash))        cell$strokeDash <- stroke_dash
  if (!is.null(stroke_dash_offset)) cell$strokeDashOffset <- stroke_dash_offset

  if(facet){
    vl$x$config$facet$cell <- cell
  } else {
    vl$x$config$cell <- cell
  }

  vl

}

#' Add cell size to main Vega-Lite spec
#'
#' Short version: set this to control the height and with of a single plot panel.
#' It will also be the size of panels in a faceted/trellis plot, so make sure your
#' viewport height/width (set in the main call to the widget) is as large as you
#' want it to be (otheriwse this will do it's best to calculate it but will probably
#' not be what you ultimately want).
#'
#' At its core, a Vega-Lite specification describes a single plot. When a
#' facet channel is added, the visualization is faceted into a trellis plot,
#' which contains multiple plots. Each plot in either a single plot or a trellis
#' plot is called a cell. Cell configuration allows us to customize each individual
#' single plot and each plot in a trellis plot.
#'
#' @param vl a Vega-Lite object
#' @param width the width of the single plot or each plot in a trellis plot when
#'        the visualization has continuous x-scale. (If the plot has ordinal x-scale, the
#'        width is determined by the x-scale’s bandSize and the cardinality of the x-scale.
#'        If the plot does not have a field on x, the width is derived from scale config’s
#'        bandSize for all marks except text and from scale config’s textBandWidth for text mark.)
#'        Default value: \code{200}
#' @param height the height of the single plot or each plot in a trellis plot when
#'        the visualization has continuous y-scale. (If the visualization has ordinal y-scale,
#'        the height is determined by the bandSize and the cardinality of the y-scale. If the
#'        plot does not have a field on y, the height is scale config’s bandSize.)
#'        Default value: \code{200}
#' @param facet a boolean to determine whether this size refers to facet cells or not.
#' @encoding UTF-8
#' @references
#'   \href{http://vega.github.io/vega-lite/docs/config.html#cell-config}{Vega-Lite Cell spec}
#' @export
#' @examples
#' vegalite() %>%
#'   cell_size(300, 200) %>%
#'   add_data("https://vega.github.io/vega-editor/app/data/unemployment-across-industries.json") %>%
#'   encode_x("date", "temporal") %>%
#'   encode_y("count", "quantitative", aggregate="sum") %>%
#'   encode_color("series", "nominal") %>%
#'   scale_color_nominal(range="category20b") %>%
#'   timeunit_x("yearmonth") %>%
#'   scale_x_time(nice="month") %>%
#'   axis_x(axisWidth=0, format="%Y", labelAngle=0) %>%
#'   mark_area()
cell_size <- function(vl, width=200, height=200, facet=FALSE) {
  vl <- cell_config(vl, width=width, height=height, facet=facet)
  vl
}

#' Facet cell aesthetics
#'
#' At its core, a Vega-Lite specification describes a single plot. When a facet
#' channel is added, the visualization is faceted into a trellis plot, which
#' contains multiple plots. Each plot in either a single plot or a trellis plot
#' is called a cell. Cell configuration allows us to customize each individual
#' single plot and each plot in a trellis plot.
#'
#' @param vl Vega-Lite object
#' @param width,height width and height property of the cell configuration determine
#'        the width of a visualization with a continuous x-scale and the height of
#'        a visualization with a continuous y-scale respectively. Visit the
#'        URL in the References section for more information.
#' @param clip \code{FALSE} by default, whether the view should be clipped.
#' @param fill fill color
#' @param fill_opacity \code{0.0}-\code{1.0}
#' @param stroke stroke color
#' @param stroke_opacity \code{0.0}-\code{1.0}
#' @param stroke_width stroke of the width in pixels
#' @param stroke_dash an array of alternating stroke, space lengths for creating
#'        dashed or dotted lines.
#' @param stroke_dash_offset the offset (in pixels) into which to begin drawing with the stroke dash array.
#' @encoding UTF-8
#' @references
#'   \href{http://vega.github.io/vega-lite/docs/config.html#facet-config}{Vega-Lite Facet spec}
#' @export
facet_cell <- function(vl, ...) {
  vl <- cell_config(vl, ..., facet=TRUE)
  vl
}

#' Facet grid aesthetics
#'
#' @param vl Vega-Lite object
#' @param grid_color color of the grid between facets.
#' @param grid_opacity \code{0.0}-\code{1.0}
#' @param grid_offset offset for grid between facets.
#' @encoding UTF-8
#' @references
#'   \href{http://vega.github.io/vega-lite/docs/config.html#facet-config}{Vega-Lite Facet spec}
#' @export
grid_facet <- function(vl, grid_color=NULL, grid_opacity=NULL, grid_offset=NULL) {

  chnl <- "config"
  if (!is.null(grid_color))   vl$x[[chnl]]$facet$grid$gridColor <- grid_color
  if (!is.null(grid_opacity)) vl$x[[chnl]]$facet$grid$gridOpacity <- grid_opacity
  if (!is.null(grid_offset))  vl$x[[chnl]]$facet$grid$gridOffset <- grid_offset

  vl

}

