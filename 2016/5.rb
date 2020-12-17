require "digest"

input = "cxdnnyjw"

index = 0
password = [nil, nil, nil, nil, nil, nil, nil, nil]

while password.any?(&:nil?)
  md5 = nil

  until md5 && md5[0, 5] == "00000"
    md5 = Digest::MD5.hexdigest("#{input}#{index}")
    index += 1
  end

  if ("0".."7").include?(md5[5])
    password[md5[5].to_i] ||= md5[6]
  end
end

puts password.join("")
