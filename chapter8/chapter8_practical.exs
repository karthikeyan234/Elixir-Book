###############################################################
# Chapter 8 Practical Exercises – Solutions
# Plugs and Internationalization in Phoenix
###############################################################

# =============================================================
# Exercise 1: Creating and Using a Custom Plug
# Objective: Build a custom plug to check if a user is authenticated.
# =============================================================

# Step 1: Define the Plug
# File: lib/your_app_web/plugs/verify_user.ex

defmodule YourAppWeb.Plugs.VerifyUser do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _opts) do
    case conn.assigns[:current_user] do
      nil ->
        conn
        |> Phoenix.Controller.redirect(to: "/login")
        |> halt()

      _user ->
        conn
    end
  end
end

# This plug checks if :current_user is present in the connection.
# If not, it redirects the user to "/login" and halts the request.


# Step 2: Add Plug to a Controller
# --------------------------------
# File: lib/your_app_web/controllers/post_controller.ex
#
# This ensures authentication is enforced for all actions in PostController.

defmodule YourAppWeb.PostController do
  use YourAppWeb, :controller
  plug YourAppWeb.Plugs.VerifyUser

  def index(conn, _params) do
    text(conn, "Only authenticated users can see this")
  end
end


# Step 3: Add Plug to the Router
# ------------------------------
# File: lib/your_app_web/router.ex
#
# Adding it to the :browser pipeline applies the check broadly.

pipeline :browser do
  plug :fetch_session
  plug :put_flash
  plug :protect_from_forgery
  plug :fetch_live_flash
  plug YourAppWeb.Plugs.VerifyUser
end

# This ensures authentication is checked on every request
# that goes through the browser pipeline.


# =============================================================
# Exercise 2: Implementing Multilingual Support with Gettext
# Objective: Enable i18n (internationalization) in Phoenix.
# =============================================================

# Step 1: Ensure gettext dependency is in mix.exs
# (Phoenix projects include it by default)
#
# Run in terminal:
#   mix deps.get


# Step 2: Extract and Merge Translations
# --------------------------------------
# Extract translatable strings:
#   mix gettext.extract
#
# Merge new strings into .po files:
#   mix gettext.merge priv/gettext


# Step 3: Provide Translations in .po files
# -----------------------------------------
# File: priv/gettext/es/LC_MESSAGES/default.po
#
# Example entry:
#   msgid "Hello, World!"
#   msgstr "¡Hola, Mundo!"


# Step 4: Use Translations in Templates
# -------------------------------------
# Example Phoenix template (eex/heex):
#
# <h1><%= gettext("Hello, World!") %></h1>
#
# This will automatically display text in the user’s locale.


# Step 5: Locale Switching with a Plug
# ------------------------------------
# File: lib/your_app_web/plugs/locale_plug.ex

defmodule MyAppWeb.LocalePlug do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _opts) do
    locale = get_session(conn, :locale) || "en"
    Gettext.put_locale(MyAppWeb.Gettext, locale)
    conn
  end
end

# Add LocalePlug to your browser pipeline in router.ex:
#
# pipeline :browser do
#   plug :fetch_session
#   plug MyAppWeb.LocalePlug
#   plug :put_flash
#   plug :protect_from_forgery
# end
#
# This ensures every request sets the correct locale.


# Step 6: Allow Users to Switch Locale
# ------------------------------------
# In your templates, add a simple dropdown or link that sets
# session[:locale] to "en", "fr", "es", etc.
#
# Example:
#   <a href="/set-locale?lang=es">Español</a>
#
# The controller handling /set-locale will update the session.
