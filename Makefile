
style-check:
	stylua . --check

style-fix:
	stylua .

fmt: style-check style-fix
