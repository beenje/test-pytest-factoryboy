# test-pytest-factoryboy

Test repo to reproduce https://github.com/pytest-dev/pytest/issues/7890

## Instructions

```
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

```
$ tree
.
├── Dockerfile
├── README.md
├── requirements.txt
└── tests
    ├── __init__.py
    ├── conftest.py
    ├── factories.py
    └── test_models.py
```

Generate `pyc` files locally:
```
$ pytest --collect-only
========================================================================================== test session starts ===========================================================================================
platform darwin -- Python 3.8.5, pytest-6.1.1, py-1.9.0, pluggy-0.13.1
rootdir: /Users/benjaminbertrand/Dev/web/flask/test-pytest-factoryboy
plugins: factoryboy-2.0.3, Faker-4.9.0
collected 1 item

<Package tests>
  <Module test_models.py>
    <Function test_author_factory>

========================================================================================= no tests ran in 0.02s ==========================================================================================
$ tree
.
├── Dockerfile
├── README.md
├── requirements.txt
└── tests
    ├── __init__.py
    ├── __pycache__
    │   ├── __init__.cpython-38.pyc
    │   ├── conftest.cpython-38-pytest-6.1.1.pyc
    │   ├── factories.cpython-38.pyc
    │   └── test_models.cpython-38-pytest-6.1.1.pyc
    ├── conftest.py
    ├── factories.py
    └── test_models.py

2 directories, 11 files
```

Create the docker image:
```
docker build -t beenje/test-pytest-factoryboy .
```

Run the tests inside the docker image:
```
$ docker run --rm beenje/test-pytest-factoryboy
============================= test session starts ==============================
platform linux -- Python 3.8.6, pytest-6.1.1, py-1.9.0, pluggy-0.13.1
rootdir: /app
plugins: Faker-4.9.0, factoryboy-2.0.3
collected 1 item

tests/test_models.py E                                                   [100%]

==================================== ERRORS ====================================
____________________ ERROR at setup of test_author_factory _____________________
file /Users/benjaminbertrand/Dev/web/flask/test-pytest-factoryboy/tests/test_models.py, line 1: source code not available
E       fixture 'author_factory' not found
>       available fixtures: _session_faker, cache, capfd, capfdbinary, caplog, capsys, capsysbinary, doctest_namespace, factoryboy_request, faker, monkeypatch, pytestconfig, record_property, record_testsuite_property, record_xml_attribute, recwarn, tmp_path, tmp_path_factory, tmpdir, tmpdir_factory
>       use 'pytest --fixtures [testpath]' for help on them.

/Users/benjaminbertrand/Dev/web/flask/test-pytest-factoryboy/tests/test_models.py:1
=========================== short test summary info ============================
ERROR tests/test_models.py::test_author_factory
=============================== 1 error in 0.05s ===============================
```
