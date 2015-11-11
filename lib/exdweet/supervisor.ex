defmodule ExDweet.Supervisor do
  use Application

  @doc false
  def start(_type,_args) do
    import Supervisor.Spec

    children = [
      supervisor(Task.Supervisor,[[name: ExDweet.RealTimeSupervisor]], id: RealTimeSupervisor),
      #supervisor(Task.Supervisor,[[name: ExDweet.RealTimeAnotherSupervisor]], id: RealTimeAnotherSupervisor),
      worker(Task,[ExDweet.RealTimeAcceptor, :acceptor,[]])
    ]

    opts = [strategy: :one_for_one, name: ExDweet.MainSupervisor]
    Supervisor.start_link(children, opts)
  end
end
