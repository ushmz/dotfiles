has docker || return

map d='docker'
map 'docker e'='docker exec'
map 'docker c'='docker compose'
map 'docker ex'='docker compose exec'
map 'docker compose e'='docker compose exec'

map dup='docker compose up -d --remove-orphans'
map ddn='docker compose down -v --remove-orphans'
map dex='docker compose exec -it'
