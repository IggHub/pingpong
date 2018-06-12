defmodule Table do
  def ping do
    receive do
      {from, :ping} ->
        IO.puts "ping-ed!"
        :timer.sleep(1000)
        send from, {self, :pong}
    end
    ping
  end

  def pong do
    receive do
      {from, :pong} ->
        IO.puts "I am pong!"
        :timer.sleep(1000)
        send from, {self, :ping}
    end
    pong
  end

  def start do
    ping_pid = spawn __MODULE__, :ping, []
    pong_pid = spawn __MODULE__, :pong, []
    {ping_pid, pong_pid} 
  end
end
