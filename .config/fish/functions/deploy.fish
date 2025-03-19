function deploy
    if test (count $argv) -ne 1
        echo "Usage: deploy <target>"
        return 1
    end

    set target $argv[1]

    # Prepare $temp_dir on $target
    ssh admin@$target '[ -d /home/admin/.tmp_deploy ] && rm -rf /home/admin/.tmp_deploy/* || mkdir -p /home/admin/.tmp_deploy;'

    if test $status -ne 0
        echo "Error preparing temp directory on target, aborting deploy...."
        return 1
    end

    # Copy ipk(s) to /home/admin/.tmp_deploy on $target
    scp -r *.ipk admin@$target:/home/admin/.tmp_deploy

    if test $status -ne 0
        echo "Error copying ipk(s) to target, aborting deploy...."
        return 1
    end

    # Install ipk(s) on $target
    # ssh admin@$target 'opkg update && opkg install /home/admin/.tmp_deploy/*.ipk && reboot || exit 1'
    ssh admin@$target 'opkg install /home/admin/.tmp_deploy/*.ipk && reboot || exit 1'

    if test $status -ne 0
        echo "Error installing ipk(s) on target, aborting deploy...."
        return 1
    end

end
