require('luasnip.session.snippet_collection').clear_snippets 'python'

local ls = require 'luasnip'

local s = ls.snippet
local i = ls.insert_node

local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('python', {
  s('main', fmt([[if __name__ == "__main__":
    {}]], { i(0) })),

  s('usecase', fmt([[class {}UseCase:
    def __init__(self, {}: {}):
        self.{} = {}

    def execute(self, request: {}) -> {}:
        {}
]], {
    i(1, 'CreateOrder'),
    i(2, 'repository'),
    i(3, 'OrderRepository'),
    i(4, 'repository'),
    i(5, 'repository'),
    i(6, 'CreateOrderRequest'),
    i(7, 'CreateOrderResponse'),
    i(0, 'raise NotImplementedError'),
  })),

  s('port', fmt([[from typing import Protocol


class {}(Protocol):
    def {}(self, {}: {}) -> {}:
        ...
]], {
    i(1, 'OrderRepository'),
    i(2, 'save'),
    i(3, 'order'),
    i(4, 'Order'),
    i(0, 'None'),
  })),

  s('entity', fmt([[from dataclasses import dataclass


@dataclass(frozen=True)
class {}:
    {}: {}
]], {
    i(1, 'Order'),
    i(2, 'id'),
    i(0, 'str'),
  })),

  s('mapper', fmt([[class {}Mapper:
    @staticmethod
    def to_entity(dto: {}) -> {}:
        {}

    @staticmethod
    def to_dto(entity: {}) -> {}:
        {}
]], {
    i(1, 'Order'),
    i(2, 'OrderDTO'),
    i(3, 'Order'),
    i(4, 'raise NotImplementedError'),
    i(5, 'Order'),
    i(6, 'OrderDTO'),
    i(0, 'raise NotImplementedError'),
  })),

  s('uow', fmt([[from contextlib import AbstractContextManager


class {}UnitOfWork(AbstractContextManager):
    {}: {}

    def __enter__(self) -> "{}UnitOfWork":
        return self

    def __exit__(self, exc_type, exc, tb) -> None:
        self.rollback()

    def commit(self) -> None:
        {}

    def rollback(self) -> None:
        {}
]], {
    i(1, 'SqlAlchemy'),
    i(2, 'orders'),
    i(3, 'OrderRepository'),
    i(4, 'SqlAlchemy'),
    i(5, 'pass'),
    i(0, 'pass'),
  })),

  s('pytest_usecase', fmt([[import pytest


def test_{}():
    {}

    result = {}.execute({})

    assert result.{} == {}
]], {
    i(1, 'create_order_success'),
    i(2, 'use_case = CreateOrderUseCase(FakeOrderRepository())'),
    i(3, 'use_case'),
    i(4, 'CreateOrderRequest()'),
    i(5, 'id'),
    i(0, '"expected-id"'),
  })),

  s('pytest_repo', fmt([[def test_{}():
    {}

    {}.{}({})

    assert {}
]], {
    i(1, 'repository_saves_entity'),
    i(2, 'repo = InMemoryOrderRepository()\n    order = Order(id="1")'),
    i(3, 'repo'),
    i(4, 'save'),
    i(5, 'order'),
    i(0, 'repo.get("1") == order'),
  })),
})
