#' GMPE function for Zhao et al.(2016)
#'
#' \code{Zh06Slab} returns the ground-motion prediction with it sigma of Zhao et al.(2016) GMPE.
#'
#'Zhao, J. et al. (2016),Ground-Motion Prediction Equations for Subduction Slab Earthquakes in
#' Japan Using Site Class and Simple Geometric Attenuation Functions,
#'Bulletin of the Seismological Society of America, 106(4), 1535-1551.
#'\url{http://dx.doi.org/10.1785/0120150056}
#'
#' @param Mag Earthquake momnet magnitude, Numeric.
#' @param Rrup Rupture distance(km), Numeric.
#' @param Prd Period of spectral acceleration.
#' @param sclass site condition, 0 for Hard Rock, 1 for SC I, 2 for SC II, 3 for SC III, 4 for SC IV.
#' @param depth focal depth(km).
#'
#' @return A list will be return, including mag, Rrup, ftype, lnY, sigma, sclass, specT, attenName, period, iflag, sourcetype, depth, phi, tau.
#'
#' @examples
#' Zh16Slab(6, 20, 1.0, 0, 10)
#' Zh16Slab(7, 10, 1.0, 0, 10)
#'
#' @export
Zh16Slab <- function(Mag, Rrup, sclass=1.0, Prd=0, depth=10){
  #subroutine Zhaoetal2016_slab ( m, dist, ftype, lnY, sigma, sclass, specT,
  #                   attenName, period1, iflag, sourcetype, depth, phiT, tauT )
  # Set attenuation name
  #     Sourcetype = 1 Subduction - Interface
  #     Sclass = 0 Hard Rock
  #     Sclass = 1 SC I
  #     Sclass = 2 SC II
  #     Sclass = 3 SC III
  #     Sclass = 4 SC IV
  retvals <- .Fortran("Zhaoetal2016_slab", m=as.single(Mag), dist=as.single(Rrup), ftype=as.single(0.0),
                      lnY=as.single(0.1), sigma=as.single(0.1), sclass=as.single(sclass),
                      specT=as.single(Prd), attenName=as.character("attenName"), period1=as.single(0), iflag=as.integer(0),
                      sourcetype=as.single(1.0), depth=as.single(depth),
                      phiT=as.single(0.0), tauT=as.single(0.0))
  names(retvals) <- c("mag", "Rrup", "ftype", "lnY", "sigma", "sclass", "specT", "attenName", "period", "iflag",
                      "sourcetype", "depth", "phi", "tau")
  retvals$attenName <- NULL
  retvals$ftype <- NULL
  retvals$sourcetype <- NULL
  return(retvals)
}
