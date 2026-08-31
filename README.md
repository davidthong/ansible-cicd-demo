# Ansible CI/CD Demo

This repository demonstrates a simple Ansible CI pipeline with:

- `ansible-playbook --syntax-check`
- `ansible-lint`
- an intentionally bad playbook that demonstrates lint violations
- Molecule testing
- Molecule idempotence testing
- Ansible-based verification
- GitHub Actions

## Demo flow

1. Show `playbooks/good.yml`
2. Show `playbooks/bad.yml`
3. Open a PR with a lint violation and show the quality gate fail
4. Fix the violation and show lint pass
5. Show the Molecule role test
6. Show the idempotence test
7. Merge only after all required checks pass

## Local setup

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
```

Run the same checks locally:

```bash
ansible-playbook --syntax-check playbooks/good.yml
ansible-lint playbooks/good.yml roles/demo_web
cd roles/demo_web
molecule test
```

Run the intentionally bad example:

```bash
ansible-lint playbooks/bad.yml
```

That command is expected to fail.

## What the Molecule role does

The role manages a deterministic file under `/tmp` so it is safe to execute on a GitHub-hosted runner. The test verifies:

- the role converges successfully
- a second run makes no changes
- the expected file exists
- the file has the expected content and mode

For a production implementation, the same pattern can be replaced with Podman/Docker, EC2, VMware, OpenShift, or another disposable test target.
# ansible-cicd-demo
