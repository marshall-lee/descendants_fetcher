# descendants_fetcher

[![Build Status](https://travis-ci.org/marshall-lee/descendants_fetcher.svg?branch=master)](https://travis-ci.org/marshall-lee/descendants_fetcher)

This gem provides functionality similar to [descendants_tracker](https://github.com/dkubb/descendants_tracker) but it doesn't store classes in the array. Instead of this it uses `ObjectSpace` approach to *fetch* descendant classes dynamically. It also separates `descendants` and `subclasses`: first is like `ancestors` but in opposite direction (*deep*), second matches strictly by superclass (*children*). See [examples below](#usage).

The main cool **feature** of this implementation is that unlike with `DescendantsTracker` parent class doesn't store references to descendant class objects when inherited. It means that it can be safely used for dynamically created classes (via `Class.new(...)`).

The main **caveat** of this implementation is that it's obviously slower than `DescendantsTracker`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'descendants_fetcher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install descendants_fetcher

## Usage

```ruby
class X
  extend DescendantsFetcher
end

class X1 < X
end

class X2 < X
end

class Y < X1
end

X.descendants
# => [X, X1, X2, Y]

X.subclasses
# => [X1, X2]

X1.superclass
# => X

X2.superclass
# => X

Class.new(X) # This class object will be safely garbage-collected!
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marshall-lee/descendants_fetcher.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

