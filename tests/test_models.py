def test_author_factory(author_factory):
    author = author_factory(name="John")
    assert author.name == "John"
