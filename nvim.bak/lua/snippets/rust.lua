local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local rep = ls.repeat_node

return {
  s('actix_runner', {
    t { 'pub mod config;', 'pub mod routes;', '' },
    t { 'use crate::' },
    i { 1, 'module_name' },
    t { ';' },
    t {
      '',
      'use actix_web::dev::Server;',
      'use actix_web::middleware::Logger;',
      'use actix_web::{web, App, HttpServer};',
      'use std::net::TcpListener;',
      'use tracing::debug;',
      '',
      'pub fn run(listener: TcpListener) -> Result<Server, std::io::Error> {',
      '    env_logger::init_from_env(env_logger::Env::default().default_filter_or("info"));',
      '',
      '    let discord_webhook = DiscordWebhook::from_env();',
      '',
      '    let server = HttpServer::new(move || {',
      '        App::new()',
      '            .wrap(Logger::default())',
      '            .app_data(web::Data::new(discord_webhook.clone()))',
      '            .service(routes::health::check)',
      '    })',
      '    .listen(listener)?',
      '    .run();',
      '',
      '    Ok(server)',
      '}',
    },
  }),
}, {
  --   s('actix_main', {
  --     t { 'use std::net::TcpListener;', '', 'use ' },
  --     i(1),
  --     t { '::run;', '' },
  --     t { '#[tokio::main]', '' },
  --     t { 'async fn main() -> Result<(), std::io::Error> {', '' },
  --     rep(1),
  --     t { '::run(TcpListener::bind("0.0.0.0:8080").expect("failed to bind to port"))?.await;' },
  --     t { '}', '' },
  --   }),
  -- }, {
  s('test_block', {
    t { '#[cfg(test)]', 'mod tests {', '    #[test]', '    fn ' },
    i(1),
    t { '() {', '        let result = 2 + 2;', '        assert_eq!(result, 4);', '    }', '}' },
  }),
}
