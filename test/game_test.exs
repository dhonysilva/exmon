defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.Game
  alias ExMon.Player

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Rafael", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Rafael", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{status: :started, player: %Player{life: 100, name: "Rafael", moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}}, computer: %Player{life: 100, name: "Robotinik", moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}}, turn: :player}

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Rafael", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{status: :started, player: %Player{life: 100, name: "Rafael", moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}}, computer: %Player{life: 100, name: "Robotinik", moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}}, turn: :player}

      assert expected_response == Game.info()

      new_state = %{status: :started, player: %Player{life: 85, name: "Rafael", moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}}, computer: %Player{life: 50, name: "Robotinik", moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}}, turn: :player}

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end
end
