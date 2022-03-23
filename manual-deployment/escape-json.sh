cat identity.json | tr -d '\n \t' | sed 's/"/\\"/g' > identity-escaped.json
