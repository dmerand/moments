defmodule MomentsWeb.AuthenticationTest do
  use Moments.DataCase
  alias MomentsWeb.Authentication, as: Auth

  describe "tokens" do
    test "test tokens" do
      assert Auth.check_token("🔥")
      assert Auth.check_token("letmein")
      refute Auth.check_token("🙁")
    end
  end
end
