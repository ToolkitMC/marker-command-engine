package com.runtoolkit.mce.command;

import com.mojang.brigadier.CommandDispatcher;
import com.runtoolkit.mce.MarkerCommandEngineMod;
import com.runtoolkit.mce.gui.MceChestGui;
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback;
import net.minecraft.server.command.CommandManager;
import net.minecraft.server.command.ServerCommandSource;
import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.text.Text;

/** Server commands for opening the MCE chest GUI. */
public final class MceCommands {
    private MceCommands() {
    }

    public static void register() {
        CommandRegistrationCallback.EVENT.register((dispatcher, registryAccess, environment) -> registerCommands(dispatcher));
        MarkerCommandEngineMod.LOGGER.info("Registered /mcegui server command.");
    }

    private static void registerCommands(CommandDispatcher<ServerCommandSource> dispatcher) {
        dispatcher.register(CommandManager.literal("mcegui")
                .executes(context -> {
                    ServerCommandSource source = context.getSource();
                    ServerPlayerEntity player = source.getPlayerOrThrow();
                    MceChestGui.open(player);
                    player.sendMessage(Text.translatable("marker_command_engine.chest.opened"), true);
                    return 1;
                }));
    }
}
