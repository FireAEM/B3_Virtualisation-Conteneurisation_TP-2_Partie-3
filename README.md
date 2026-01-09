# B3_Virtualisation-Conteneurisation_TP-2_Partie-3

Application Flask avec pipeline CI/CD automatisé.
## Développement local
```bash
docker compose up
```

## Tests
```bash
docker compose run --rm app pytest
```

## Build
```bash
docker build -t myapp:latest .
```
