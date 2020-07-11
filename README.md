```
source bash_profile.sh # to get all the juice
```

General purpose:
- `removeEmptyDirs`
- `reload` "re-source" the bash_profile
- `code` opens Visual Studio Code
- `list_extensions`
- `is_cmd`
- `addDockSep` adds a macOS Dock separator
- `sizegz` downloads an asset and displays the size gzipped

Networking:
- `tcp` list applications using a specific port
- `killport` kills an application using a specific port
- `httpserver` spawns an http server using ./public as asset directory

Image processing:
- `pngtojpg`
- `heictojpg`

Webpack:
- `wds` kills webpack dev server then runs `yarn webpack:server`. Pretty specific, customize as you will
- `killwds` kills webpack dev server

Git: 
- `gitlocal` displays local only branches
- `gitnewbranch` fetches origin, creates a new branch and resets to origin/master
- `gitc` adds all files and commits them
- `gitp` pushes to upstream
- `gitpf` pushes to upstream using force
- `git-cleanup`
- `gitnotpushed`
- `gitlb` lists local branches in a nice format
- `gitdel` deletes the specified branch
- `gitcp` gitc + gitp
- `gitwip` commits and pushes with "Stopping point" as message
- `gitamendp` amends a commit and force pushes
- `gitpullr` pulls master with rebase
- `gitpushall` pushes all branches to origin
