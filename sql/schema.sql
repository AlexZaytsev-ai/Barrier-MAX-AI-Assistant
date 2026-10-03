-- Минимальная совместимая схема для новой тестовой базы.
-- Восстановлена по запросам workflow, не является экспортом рабочей БД.

CREATE TABLE IF NOT EXISTS door_chat_messages (
    id BIGSERIAL PRIMARY KEY,
    session_key TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('user', 'assistant')),
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS door_chat_messages_session_id_idx
    ON door_chat_messages (session_key, id DESC);

CREATE TABLE IF NOT EXISTS door_chat_modes (
    session_key TEXT PRIMARY KEY,
    mode TEXT NOT NULL DEFAULT 'ai' CHECK (mode IN ('ai', 'waiting', 'human')),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
