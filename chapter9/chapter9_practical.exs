###############################################################
# Chapter 9 Practical Exercises – Solutions
# Exercise: Managing and Updating Dependencies with Mix
###############################################################

# Step 1: Check for outdated dependencies
# ---------------------------------------
# In your Phoenix project root, run:
#   mix hex.outdated
#
# This command lists dependencies with:
#   - Current version
#   - Latest available version
#   - Whether it’s direct or transitive

IO.puts("Run `mix hex.outdated` in terminal to check outdated dependencies")


# Step 2: Update outdated dependencies
# ------------------------------------
# Update a single dependency (example: phoenix):
#   mix deps.update phoenix
#
# Update all outdated dependencies:
#   mix deps.update --all

IO.puts("Run `mix deps.update <dep_name>` or `mix deps.update --all` to update dependencies")


# Step 3: Resolve compatibility issues
# ------------------------------------
# After updating, recompile your project:
#   mix compile
#
# If you see errors/warnings:
#   - Adjust code or configs
#   - Check changelogs for breaking changes

IO.puts("Run `mix compile` to ensure compatibility after updating dependencies")


# Step 4: Test your application
# ------------------------------
# Run the full test suite:
#   mix test
#
# Also perform manual testing to confirm app stability.

IO.puts("Run `mix test` to confirm updates didn’t break your app")


# Step 5: Commit changes
# -----------------------
# Once everything works, commit changes to version control:
#   git add mix.lock
#   git commit -m 'Update dependencies'
#
# This ensures your project is locked to the verified versions.

IO.puts("Don’t forget to commit your updated mix.lock and related changes")
