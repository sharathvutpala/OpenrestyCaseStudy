# as puppet is running in standalone mode, we should add this

node default {
    include openresty_local
}
