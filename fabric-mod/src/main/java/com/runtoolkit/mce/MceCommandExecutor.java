package com.runtoolkit.mce;

import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.text.Text;

/** Shared helper for executing vanilla server commands from MCE buttons/items. */
public final class MceCommandExecutor {
    private MceCommandExecutor() {
    }

    public static int run(ServerPlayerEntity player, String commandWithoutSlash) {
        if (player.getServer() == null) {
            player.sendMessage(Text.translatable("marker_command_engine.feedback.no_server"), false);
            return 0;
        }

        String command = commandWithoutSlash.trim();
        while (command.startsWith("/")) {
            command = command.substring(1).trim();
        }

        if (command.isEmpty()) {
            player.sendMessage(Text.translatable("marker_command_engine.feedback.empty_command"), false);
            return 0;
        }

        return player.getServer().getCommandManager().executeWithPrefix(player.getCommandSource(), command);
    }
}
