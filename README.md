# ActiveWorkflow Agent Example in Elixir

This project implements a simple example agent for [ActiveWorkflow](https://github.com/automaticmode/active_workflow).
The agent is implemented in Elixir and uses the [remote agent API](https://docs.activeworkflow.org/remote-agent-api).

This agent doesn't do anything particularly useful but demonstrates some of the
features of ActiveWorkflow's Remote Agent API. The agent simply records the the
number of `check` and `receive` calls it sees in memory and returns messages
with the current count.

