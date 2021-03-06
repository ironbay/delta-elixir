defmodule Delta.Server.Listener do
	alias Socket.Web

	def accept(port) do
		server = port |> Web.listen!
		loop(server)
	end

	defp loop(server) do
		case server |> Web.accept do
			{:ok, socket } ->
				case Web.accept!(socket, []) do
					_ ->
						Delta.Supervisor.start_child(Delta.Server.Connection, [socket])
					_ -> :skip
				end
			_ -> :skip
		end
		loop(server)
	end

end
