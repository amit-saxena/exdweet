#ExDweet [![Build Status](https://travis-ci.org/amit-saxena/exdweet.svg?branch=master)](https://travis-ci.org/amit-saxena/exdweet) [![Hex pm](http://img.shields.io/hexpm/v/exdweet.svg?style=flat)](https://hex.pm/packages/exdweet) [![hex.pm downloads](https://img.shields.io/hexpm/dt/exdweet.svg?style=flat)](https://hex.pm/packages/exdweet)

Dweet.io client library for Elixir/Erlang

In Works - ExDweet now supports receiving concurrent dweets from multiple things. Included support for Real-time Streams.

##Usage

###Dweeting

```iex
iex> ExDweet.start
iex> ExDweet.dweet "ExDweet_DemoThing",%{key1: "value1", key2: "value2",key3: "value3"}
{:ok,
 %{"by" => "dweeting", "the" => "dweet", "this" => "succeeded",
   "with" => %{"content" => %{"key1" => "value1", "key2" => "value2",
       "key3" => "value3"}, "created" => "2015-10-28T21:05:56.980Z",
     "thing" => "ExDweet_DemoThing"}}}
```

###Getting Dweets

```iex
iex> ExDweet.start
iex> ExDweet.get "ExDweet_DemoThing"
{:ok,     
 %{"by" => "getting", "the" => "dweets", "this" => "succeeded",
   "with" => [%{"content" => %{"key1" => "value1", "key2" => "value2",
        "key3" => "value3"}, "created" => "2015-10-28T21:05:56.980Z",
      "thing" => "ExDweet_DemoThing"}]}}
```

Supports following :

- Dweeting and Getting Dweets via http or https.
- Dweet data passing and retrieval as JSON.
- In Works - Support for concurrent Real-time stream for multiple things

Features not supported, In works
- Alerts
