P={'A'=>:r,'B'=>:p,'C'=>:s,'X'=>:r,'Y'=>:p,'Z'=>:s};B={r:1,p:2,s:3};W={r: :s,s: :p,p: :r};puts File.readlines('02.txt').map(&:split).sum{|o,p|o,p=P[o],P[p];B[p]+(o==p ?3:W[o]==p ?0:6)}
