package com.runtoolkit.mce.client;

import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;
import net.minecraft.client.MinecraftClient;
import net.minecraft.text.Text;

/** Utility methods for sending server commands from client GUI buttons. */
@Environment(EnvType.CLIENT)
final class MceClientCommandSender {
    private MceClientCommandSender() {
    }

    static boolean sendServerCommand(String commandWithoutSlash) {
        MinecraftClient client = MinecraftClient.getInstance();
        if (client.player == null || client.player.networkHandler == null) {
            MarkerCommandEngineClient.sendFeedback(Text.translatable("marker_command_engine.gui.feedback.not_connected"));
            return false;
        }

        String command = commandWithoutSlash.trim();
        while (command.startsWith("/")) {
            command = command.substring(1);
        }

        if (command.isEmpty()) {
            MarkerCommandEngineClient.sendFeedback(Text.translatable("marker_command_engine.gui.feedback.empty"));
            return false;
        }

        client.player.networkHandler.sendChatCommand(command);
        return true;
    }

    static void sendFunction(String functionId) {
        if (sendServerCommand("function " + functionId)) {
            MarkerCommandEngineClient.sendFeedback(Text.translatable("marker_command_engine.gui.feedback.sent", "/function " + functionId));
        }
    }

    static void runMceCommand(String engineCommand) {
        String command = normalizeEngineCommand(engineCommand);
        if (command.isEmpty()) {
            MarkerCommandEngineClient.sendFeedback(Text.translatable("marker_command_engine.gui.feedback.empty"));
            return;
        }

        sendServerCommand("data modify storage mce:cmd Command set value " + quoteNbtString(command));
        sendServerCommand("function mce:api/run/cmd");
        MarkerCommandEngineClient.sendFeedback(Text.translatable("marker_command_engine.gui.feedback.mce_run"));
    }

    static void queueMceCommand(String engineCommand) {
        String command = normalizeEngineCommand(engineCommand);
        if (command.isEmpty()) {
            MarkerCommandEngineClient.sendFeedback(Text.translatable("marker_command_engine.gui.feedback.empty"));
            return;
        }

        sendServerCommand("data modify storage mce:cmd Command set value " + quoteNbtString(command));
        sendServerCommand("function mce:api/queue/add");
        MarkerCommandEngineClient.sendFeedback(Text.translatable("marker_command_engine.gui.feedback.queued"));
    }

    static void scheduleMceCommand(String engineCommand, int delayTicks) {
        String command = normalizeEngineCommand(engineCommand);
        int safeDelay = Math.max(1, delayTicks);
        if (command.isEmpty()) {
            MarkerCommandEngineClient.sendFeedback(Text.translatable("marker_command_engine.gui.feedback.empty"));
            return;
        }

        sendServerCommand("data modify storage mce:cmd Command set value " + quoteNbtString(command));
        sendServerCommand("data modify storage mce:cmd Delay set value " + safeDelay);
        sendServerCommand("function mce:api/schedule/run");
        MarkerCommandEngineClient.sendFeedback(Text.translatable("marker_command_engine.gui.feedback.scheduled", safeDelay));
    }

    static void broadcastMessage(String message) {
        String normalized = message.trim();
        if (normalized.isEmpty()) {
            MarkerCommandEngineClient.sendFeedback(Text.translatable("marker_command_engine.gui.feedback.empty"));
            return;
        }

        sendServerCommand("data modify storage mce:broadcast Prefix set value " + quoteNbtString("[MCE]"));
        sendServerCommand("data modify storage mce:broadcast Msg set value " + quoteNbtString(normalized));
        sendServerCommand("function mce:api/util/broadcast");
        MarkerCommandEngineClient.sendFeedback(Text.translatable("marker_command_engine.gui.feedback.broadcast"));
    }

    private static String normalizeEngineCommand(String command) {
        String normalized = command.trim();
        while (normalized.startsWith("/")) {
            normalized = normalized.substring(1).trim();
        }
        return normalized;
    }

    /** Quote a Java string as a simple SNBT string literal. */
    private static String quoteNbtString(String value) {
        StringBuilder builder = new StringBuilder(value.length() + 2);
        builder.append('"');
        for (int i = 0; i < value.length(); i++) {
            char c = value.charAt(i);
            switch (c) {
                case '\\' -> builder.append("\\\\");
                case '"' -> builder.append("\\\"");
                case '\n' -> builder.append("\\n");
                case '\r' -> builder.append("\\r");
                case '\t' -> builder.append("\\t");
                default -> {
                    if (c >= 0x20) {
                        builder.append(c);
                    }
                }
            }
        }
        builder.append('"');
        return builder.toString();
    }
}
