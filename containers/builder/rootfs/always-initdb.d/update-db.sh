#!/bin/sh

if [ -e /sql/world-new.sql ]; then
  echo "[mariadb]: Executing world-new.sql"
  SQL_COMMAND=$(cat <<EOF
DROP DATABASE IF EXISTS \`wotlkmangos\`;
CREATE DATABASE \`wotlkmangos\` DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
GRANT ALL ON \`wotlkmangos\`.* TO '${MARIADB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
  )

  mariadb -u root -p"$MARIADB_ROOT_PASSWORD" -e "$SQL_COMMAND"
  mariadb -u root -p$MARIADB_ROOT_PASSWORD wotlkmangos < /sql/world-new.sql
fi

if [ -e /sql/migrations/world_db_updates.sql ]; then
  echo "[mariadb]: Executing world_db_updates.sql"
  mariadb -u root -p"$MARIADB_ROOT_PASSWORD" wotlkmangos < /sql/migrations/world_db_updates.sql
fi

if [ -e /sql/migrations/characters_db_updates.sql ]; then
  echo "[mariadb]: Executing characters_db_updates.sql"
  mariadb -u root -p"$MARIADB_ROOT_PASSWORD" wotlkcharacters < /sql/migrations/characters_db_updates.sql
fi

if [ -e /sql/migrations/logon_db_updates.sql ]; then
  echo "[mariadb]: Executing logon_db_updates.sql"
  mariadb -u root -p"$MARIADB_ROOT_PASSWORD" wotlkrealmd < /sql/migrations/logon_db_updates.sql
fi

if [ -e /sql/migrations/logs_db_updates.sql ]; then
  echo "[mariadb]: Executing logs_db_updates.sql"
  mariadb -u root -p"$MARIADB_ROOT_PASSWORD" wotlklogs < /sql/migrations/logs_db_updates.sql
fi