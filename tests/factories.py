import factory
from faker import Factory as FakerFactory

faker = FakerFactory.create()


class Author:
    def __init__(self, name):
        self.name = name


class AuthorFactory(factory.Factory):

    name = factory.LazyAttribute(lambda x: faker.name())

    class Meta:
        model = Author
