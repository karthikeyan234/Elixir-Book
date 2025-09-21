###############################################################
# Chapter 10 Practical Exercises – Solutions
###############################################################

# Exercise 1: Building a Reusable Title Component
# -----------------------------------------------
# Create a Title component that renders a heading and optional subtitle.
# Save in: lib/my_app_web/components/title.ex

defmodule MyAppWeb.Components.Title do
  use Phoenix.Component

  @doc "Renders a title with optional subtitle"
  attr :text, :string, required: true
  attr :subtitle, :string, default: nil

  def title(assigns) do
    ~H"""
    <header>
      <h1 class="text-2xl font-bold"><%= @text %></h1>
      <%= if @subtitle do %>
        <p class="text-slate-600"><%= @subtitle %></p>
      <% end %>
    </header>
    """
  end
end

# Fully-qualified call in a template:
#   <MyAppWeb.Components.Title.title text="Dashboard" subtitle="Overview" />

# Shorthand usage (after import in web.ex):
#   <.title text="Dashboard" subtitle="Overview" />


# Exercise 2: Conditional Rendering in a Component (StatusTag)
# ------------------------------------------------------------
# Create a component that renders different colors based on a "status".
# Save in: lib/my_app_web/components/status_tag.ex

defmodule MyAppWeb.Components.StatusTag do
  use Phoenix.Component

  @doc "Renders a colored tag for active/inactive/pending"
  attr :status, :string, required: true

  def status_tag(assigns) do
    ~H"""
    <span class={
      case @status do
        "active" -> "px-2 py-1 rounded bg-green-100 text-green-800"
        "inactive" -> "px-2 py-1 rounded bg-red-100 text-red-800"
        _ -> "px-2 py-1 rounded bg-gray-100 text-gray-800"
      end
    }>
      <%= String.capitalize(@status) %>
    </span>
    """
  end
end

# Usage in a template:
#   <.status_tag status="active" />
#   <.status_tag status="inactive" />
#   <.status_tag status="pending" />


# Exercise 3: Looping Through Data in a Component (UserList)
# ----------------------------------------------------------
# Create a component that iterates through a list of users.
# Save in: lib/my_app_web/components/user_list.ex

defmodule MyAppWeb.Components.UserList do
  use Phoenix.Component

  @doc "Displays a list of users. Each user is a map with :name and :active."
  attr :users, :list, required: true

  def user_list(assigns) do
    ~H"""
    <ul class="list-disc pl-6">
      <%= for user <- @users do %>
        <%= if Map.get(user, :active, true) do %>
          <li><%= user.name %></li>
        <% end %>
      <% end %>
    </ul>
    """
  end
end

# Usage:
#   <.user_list users=[%{name: "Alice", active: true}, %{name: "Bob", active: false}] />


# Exercise 4: Slot-based Components (Card)
# ----------------------------------------
# Create a Card component that accepts header and body slots.
# Save in: lib/my_app_web/components/card.ex

defmodule MyAppWeb.Components.Card do
  use Phoenix.Component

  @doc "A card with optional header and main content slot"
  slot :header
  slot :inner_block, required: true

  def card(assigns) do
    ~H"""
    <section class="border rounded p-4 shadow-sm">
      <%= if @header != [] do %>
        <header class="mb-2 font-medium">
          <%= render_slot(@header) %>
        </header>
      <% end %>
      <%= render_slot(@inner_block) %>
    </section>
    """
  end
end

# Usage:
#   <.card>
#     <:header><h3>Recent Activity</h3></:header>
#     <p>No activity in the last 24 hours.</p>
#   </.card>


# Exercise 5: Composing Components Together (Dashboard)
# -----------------------------------------------------
# Combine Title, StatusTag, UserList, and Card components into a dashboard page.

# In a template (lib/my_app_web/controllers/page_html/dashboard.html.heex):
"""
<.title text="Team Dashboard" subtitle="System & Users" />

<div class="grid gap-6 md:grid-cols-2">
  <.card>
    <:header>System Status</:header>
    <p>API: <.status_tag status="active" /></p>
    <p>Jobs: <.status_tag status="pending" /></p>
  </.card>

  <.card>
    <:header>Active Users</:header>
    <.user_list users={[
      %{name: "Alice", active: true},
      %{name: "Bob", active: false},
      %{name: "Carol", active: true}
    ]} />
  </.card>
</div>
"""


# Exercise 6: Refactoring Templates into Components (Button)
# ----------------------------------------------------------
# Extract repeated button HTML into a reusable Button component.

defmodule MyAppWeb.Components.Button do
  use Phoenix.Component

  @doc "Renders a button with :primary or :secondary variant"
  attr :label, :string, required: true
  attr :variant, :atom, default: :primary
  attr :rest, :global

  def button(assigns) do
    ~H"""
    <button
      class={
        case @variant do
          :primary -> "px-3 py-2 rounded bg-blue-600 text-white hover:bg-blue-700"
          :secondary -> "px-3 py-2 rounded bg-gray-200 text-gray-800 hover:bg-gray-300"
        end
      }
      {@rest}
    >
      <%= @label %>
    </button>
    """
  end
end

# Usage:
#   <.button label="Save" phx-click="save" />
#   <.button label="Cancel" variant={:secondary} phx-click="cancel" />


# Exercise 7: Challenge Project – Mini UI Library Page
# ----------------------------------------------------
# Build a demo page that showcases Title, StatusTag, Card, and Button together.

# Example template:
"""
<.title text="UI Library Demo" subtitle="Reusable Phoenix Components" />

<div class="space-y-6">
  <.card>
    <:header>Buttons</:header>
    <.button label="Primary" />
    <.button label="Secondary" variant={:secondary} />
  </.card>

  <.card>
    <:header>Status Tags</:header>
    <.status_tag status="active" />
    <.status_tag status="inactive" />
    <.status_tag status="pending" />
  </.card>
</div>
"""
