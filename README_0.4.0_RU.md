# WhiteList Transport Test 0.4.0

## Исправлено

- настоящий `LaunchScreen.storyboard`;
- удалён пустой `UILaunchScreen`, из-за которого приложение могло запускаться
  в совместимом letterbox-режиме;
- интерфейс использует всю высоту современного iPhone;
- убрана верхняя системная NavigationBar;
- уменьшены отступы и шрифты;
- показывается стадия подключения;
- показывается commit olcRTC core;
- добавлено копирование полной диагностики;
- IPA и серверный Linux-бинарник собираются из одного commit olcRTC.

## Важно после установки

Старую версию приложения нужно полностью удалить с iPhone, затем установить 0.4.0.
iOS кэширует launch screen, и обычная установка поверх старой версии может
оставить прежний letterbox.

## Artifact

GitHub Actions создаёт:

```text
WhiteList-0.4.0-iPhone-and-Matched-Server
```

Внутри:

```text
WhiteListTransportTest-unsigned.ipa
olcrtc-linux-amd64
OLCRTC_COMMIT.txt
install_matched_server.sh
build.log
```

## Обновление сервера

Загрузи на VPS два файла:

```text
olcrtc-linux-amd64
install_matched_server.sh
```

Запусти:

```bash
chmod +x install_matched_server.sh olcrtc-linux-amd64
sudo ./install_matched_server.sh ./olcrtc-linux-amd64
```

После этого сервер и iPhone используют один и тот же commit core.
