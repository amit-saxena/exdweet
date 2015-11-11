defmodule ExDweet.Import do
   defmacro __using__(_) do
   quote do
      require ExDweet.Configuration
      alias ExDweet.Configuration, as: C
      @doc false
      use HTTPoison.Base
      @derive [Poison.Encoder]

      def start do
        {:ok, _} = HTTPoison.start
        #:application.ensure_all_started(:exdweet)
        {:ok,:exdweet}
      end

      @doc """
      Dweet by providing thing name and thing data for dweeting.

      Args:
        * `thing_name` - name of thing as a binary string or char list
        * `thing_data` - data to dweet. See more below
        * `type` - input data type of `thing_data` as an atom (`:default`, `:json`). ':json' only supported when 'method' type is ':post'
        * `method` - HTTP method to use for dweet as an atom (`:query`, `:post`).
        * `transport` - HTTP transport to use as an atom (`:https`, `:http`)

      Thing Data:
        * As Map - %{:key1 => "value1", :key2 => "value2", :key3 => "value3"}
        * or
        * As JSON encoded data as binary string or char list - "\{ \"key1\":\"value1\", \"key2\":\"value2\", \"key3\":\"value3\"\}"

      This function returns `{:ok, response}` if the request is successful, else `{:error, reason}`
      """
      def dweet(thing_name, thing_data, type \\ :default, method \\ :post, transport \\ :https) do
        dweetp {transport, method, thing_name, thing_data, type}
      end

      @doc """
      Dweet by providing thing name and thing data for dweeting, raising an
      exception in case of failure.

      `dweet!/5` works similar to `dweet/5` but response is returned in case of
      successful dweet, an exception is raised in case of failure.
      """
      def dweet!(thing_name, thing_data, type \\ :default, method \\ :post, transport \\ :https) do
        case dweetp {transport, method, thing_name, thing_data, type} do
          {:ok, response} -> {:ok, response}
          {:error, error} -> raise error
        end
      end

      @doc """
      Get dweet by providing thing name. This method will return latest or all dweets of thing

      Args:
        * `thing_name` - name of thing as a binary string or char list
        * `return` - return dweets (`:latest`, `:all`)
        * `type` - data type to return for dweets as an atom (`:default`, `:json`)
        * `transport` - HTTP transport to use as an atom (`:https`, `:http`)

      This function returns `{:ok, result}` if the request is successful, else `{:error, reason}`
      """
      def get(thing_name, return \\ :latest, type \\ :default, transport \\ :https, options \\ [])  do
        getp {return,thing_name,transport, type, options}
      end

      @doc """
      Get dweet by providing thing name. This method will return latest or all dweets of thing

      `get!/4` works similar to `get/5` but result is returned in case of
      successful dweet, an exception is raised in case of failure.
      """
      def get!(thing_name, return \\ :latest, type \\ :default, transport \\ :https, options \\ [])  do
        case getp {return,thing_name,transport, type, options} do
          {:ok, response} -> {:ok, response}
          {:error, error} -> raise error
        end
      end

      defp getp({return,thing_name,transport, type, options}) do
          result = case return do
            :latest -> HTTPoison.get to_string(transport) <> C.url_latest <> thing_name
            :all -> HTTPoison.get to_string(transport) <> C.url_all <> thing_name
          end
          return_result(result, type)
      end

      defp dweetp({_transport, method, _thing_name, _thing_data, type}) when type == :json and method == :query do
        {:error , ":json not supported with :query clause. For :query use without :json or :default"}
      end

      defp dweetp({transport, method, thing_name, thing_data, type}) do
        result = case method do
          :query -> HTTPoison.get to_string(transport) <> C.url_dweet <> thing_name, [], params: thing_data
          :post ->  HTTPoison.post to_string(transport) <> C.url_dweet <> thing_name,
                          (if type == :default, do: Poison.encode!(thing_data), else: thing_data),
                          %{"Content-type" => "application/json"}
        end
        return_result(result,type)
      end

      defp return_result(result, type) do
        case result do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok,
                                  (if type == :default, do: Poison.decode!(body), else: body) }
          {:ok, %HTTPoison.Response{status_code: 404}} -> {:ok,404}
          {:error, %HTTPoison.Error{reason: reason}} -> {:error,reason}
        end
      end

      def get_realtime(callback) do #thing_name,
          #Send callback method to acceptor 
      end
  end
end
end
