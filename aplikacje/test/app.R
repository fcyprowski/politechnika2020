#* @get /multiply
function(x, y = 6) {
  return(as.numeric(x) * as.numeric(y))
}