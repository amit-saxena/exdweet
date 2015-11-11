defmodule ExDweet.RealTimeAcceptor do
    defp process_realtime_dweets(dweets), do: dweets

    @doc false
    ## Accept request for dweets
    #process_realtime_dweets(:ok)
    def acceptor() do
      receive do
        {:getstream,thingname} ->
          Task.Supervisor.start_child(ExDweet.RealTimeSupervisor, fn -> serve(thingname) end)
          acceptor
      end
    end

    defp serve(thingname) do
      #when data is received call process_realtime_dweets
      process_realtime_dweets(thingname)
      serve(thingname) ##TEMP
    end
end
