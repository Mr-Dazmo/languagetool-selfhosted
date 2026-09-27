# languagetool-selfhosted
languagetool-selfhosted spell checker container

## Verify LanguageTool

Replace `TRUENAS-IP` with the IP address of your TrueNAS server.

```bash
curl -s \
  -d "language=en-US" \
  --data-urlencode "text=This sentance has alot of speling erors." \
  http://TRUENAS-IP:8081/v2/check
```

A successful response should return JSON containing suggested corrections.

## Browser Extension

Configure the LanguageTool browser extension to use **Other server** and enter:

```text
http://TRUENAS-IP:8081/v2
```
