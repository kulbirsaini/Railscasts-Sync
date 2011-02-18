# RailscastsSync

Ruby script to sync [Railscasts episodes](http://railscasts.com/).
    
## Usage

Download the script.

    # Using git
    $ git clone git@github.com:kulbirsaini/Railscasts-Sync.git

    # Or directly via HTTP [railscasts_sync.rb](https://github.com/kulbirsaini/Railscasts-Sync/raw/master/railscasts_sync.rb)
    $ wget https://github.com/kulbirsaini/Railscasts-Sync/raw/master/railscasts_sync.rb

Create Railscasts directory

    # Create Railscasts directory
    $ mkdir Railscasts

Switch to Railscasts directory

    # Switch to Railscasts directory
    $ cd Railscasts

Export http_proxy shell variable if you are behing a proxy server

    # If behind a proxy server
    $ export http_proxy='http://proxy.example.com:8080/'

Run the script :)

    # Run the sync script
    $ ruby railscasts_sync.rb

## Autosync

Setup a cron job (Daily at 1AM)

    # Edit crontabs
    $ crontab -e

    # Add cron job for railscasts_sync
    0 1 * * * cd /path/to/Railscasts/ && ruby /path/to/Railscasts/sync.rb >> /tmp/railscasts_sync.log

    # Or if you are behind a proxy server
    0 1 * * * cd /path/to/Railscasts/ && export http_proxy='http://proxy.example.com:8080/' && ruby /path/to/Railscasts/sync.rb >> /tmp/railscasts_sync.log


## Copyright

Copyright (c) ROFLMAO LLC.

