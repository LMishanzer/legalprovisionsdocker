# Spuštění systému pomocí Docker

```docker-compose up -d --build```

Po spuštění příkazu, Dockerfile vygeneruje potřebný image s
aplikaci a stáhne image MongoDB, Elasticsearch a Kibana.
Pak vytvoří potřebné kontejnery pomocí nastavení v souboru 
"docker-compose.yml".

Také aplikace běží na adrese http://95.179.243.24/ , kde jí můžete vyzkoušet
bez nutností jí spouštět.

# GitLab

Repository s backendem: https://gitlab.fit.cvut.cz/leskimyk/LegalProvisionsBackend


Repository s frontendem: https://gitlab.fit.cvut.cz/leskimyk/LegalProvisionsApplication
