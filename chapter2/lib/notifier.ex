defmodule Notifier do
  @callback send_notification(to :: String.t(), message :: String.t()) ::
              {:ok, String.t()} | {:error, String.t()}
end

defmodule SmsNotifier do
  @behaviour Notifier

  def send_notification(to, message) do
    # Simulate sending an SMS...
    {:ok, "SMS sent to #{to} with message: #{message}"}
  end
end

defmodule EmailNotifier do
  @behaviour Notifier

  def send_notification(to, message) do
    # Simulate sending an email...
    {:ok, "Email sent to #{to} with message: #{message}"}
  end
end
