format:
	shfmt -w .
	npx -y prettier -w .

list-deps:
	@rg --json -U '#\? https://.*\nPACKAGE_VERSION=.*' |\
		jq -r 'select(.type == "match") | "\(.data.path.text):\(.data.line_number+1):17\n\(.data.lines.text[3:])"'

.PHONY: format list-deps
