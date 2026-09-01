.PHONY: install syntax lint bad-lint molecule ci

install:
	python -m pip install --upgrade pip
	pip install -r requirements.txt

syntax:
	ansible-playbook --syntax-check playbooks/good.yml

lint:
	ansible-lint playbooks/good.yml roles/demo_web

bad-lint:
	ansible-lint playbooks/bad.yml

molecule:
	cd roles/demo_web && molecule test

ci: syntax lint molecule
