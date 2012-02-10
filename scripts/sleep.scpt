tell application "iTunes" to quit

log "Finder is ejecting all disks…"
tell application "Finder" to eject (every disk whose ejectable is true or ¬
	local volume is false)

log "Muting the volume…"
set volume with output muted
