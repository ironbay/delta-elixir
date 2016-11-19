defmodule Delta.Base do

		defmacro __using__(_opts) do
			quote do
				Module.register_attribute(__MODULE__, :interceptors, accumulate: false)
				Module.register_attribute(__MODULE__, :read, accumulate: false)
				Module.register_attribute(__MODULE__, :writes, accumulate: false)
				@interceptors []
				@writes []
				@read []
				@before_compile Delta.Base
			end
		end

		defmacro __before_compile__(_env) do
			quote do
				def interceptors, do: @interceptors || []
				def writes, do: @writes || []
				def read, do: @read || []
			end
		end
end

defmodule Delta.Sample do
	use Delta.Base
	use Delta.Plugin.Mutation
	use Delta.Plugin.Query
	use Delta.Plugin.Watch
	use Delta.Plugin.Fact

	@interceptors [
		Delta.Sample.Interceptor
	]

	@read {Delta.Stores.Cassandra, %{}}

	@writes [
		{Delta.Stores.Cassandra, %{}}
	]

	def sample_fact do
		query_fact([
			[:from, :package],
			[:account, "user:key", "0NeFW0nMZdLlqp80B2HW"],
			[:account, "context:type", "contextio"],
			[:account, "email:key", :email],
			[:package, "package:email", :email],
			[:email, "email:from", :from],

		])
	end


end

defmodule Delta.Sample.Interceptor do
	use Delta.Interceptor

	def intercept_write([], _user, _atom, _mutation) do
		:ok
	end

end
