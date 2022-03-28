cat identity.json | tr -d ' \n\r\t' |  sed 's/"/\\"/g' > identity-escaped.json
