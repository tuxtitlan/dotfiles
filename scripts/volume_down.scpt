property airfoil : load script POSIX file "/Users/george/.scripts/airfoil.scpt"
property iTunes : load script POSIX file "/Users/george/.scripts/itunes.scpt"

tell airfoil to changeVolume(-0.04)

tell iTunes to changeVolume(-4)
