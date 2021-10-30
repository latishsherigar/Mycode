    #!/bin/sh
    #
    # Startup script for SDES db Backup

# chkconfig: 35 99 1
# description: 	Startup script for SDES db Backup.

    # Source function library.
    . /etc/rc.d/init.d/functions

    SDES_DB_BACKUP_HOME=/opt/sdes/backup/db
    export SDES_DB_BACKUP_HOME

    do_db_backup=$SDES_DB_BACKUP_HOME/backup_db.sh
    
    start() {
    echo -n "Backing up DB "
    ${do_db_backup}
    echo "done."
    }
    
    # See how we were called
    case "$1" in
    start)
    start
    ;;
    stop)
    start
    ;;
    restart)
    start
    ;;
    *)
    echo "Usage: no parameters"
    esac
    
    exit 0
