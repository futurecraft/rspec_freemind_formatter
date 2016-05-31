Should be executed in TERMINAL
See the below examples for execution
Corresponding parameters like PATH to project, including/excluding/ignoring tags should be changed accordingly:

> MAC should be executed from the project folder:
rspec --dry-run --require rspec/legacy_formatters --require /Users/nni/247E_GIT/TR_formatter/rspec_free_mind_formatter.rb --format RSpecFreeMindFormatter --out results.xml --tag done --tag ~drag_n_drop

> WIN should be executed from the project folder
rspec --dry-run --require rspec/legacy_formatters --require F:\Projects\formatter\rspec_free_mind_formatter.rb --format RSpecFreeMindFormatter --out results.xml --tag done --tag ~drag_n_drop