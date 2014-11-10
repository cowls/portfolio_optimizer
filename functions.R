get.asset.returns <- function(assetName) {
  asset.prices = get.hist.quote(instrument=assetName, start="2008-01-01", quote="AdjClose", provider="yahoo", origin="1970-01-01", compression="m", retclass="zoo")
  colnames(asset.prices) = assetName
  asset.returns = diff(log(asset.prices))
  asset.returns
}

get.asset.data <- function(assetName) {
  asset.returns.mat = coredata(get.asset.returns(assetName))
  asset.returns.mat
}

get.asset.summary <- function(assetName, data, w0) {
    mu = mean(data)
    variance = as.numeric(var(data))
    sd = sqrt(variance)

    valatrisk = abs(w0 * (exp(qnorm(0.05,mu, sd)) - 1))
    valatrisk = round(valatrisk,2)
    
    summary.vec = c(assetName, paste(round(mu*100,2),"%"), paste(round(sd*100,2),"%"), paste("$",valatrisk))
    summary.vec
}