package com.runtoolkit.mce.gui;

import com.runtoolkit.mce.MceCommandExecutor;
import com.runtoolkit.mce.item.MceItems;
import net.minecraft.entity.player.PlayerEntity;
import net.minecraft.entity.player.PlayerInventory;
import net.minecraft.inventory.Inventory;
import net.minecraft.item.ItemStack;
import net.minecraft.screen.GenericContainerScreenHandler;
import net.minecraft.screen.ScreenHandlerType;
import net.minecraft.screen.slot.SlotActionType;
import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.text.Text;

/** Chest-style MCE control panel using Minecraft's built-in generic 9x3 screen. */
public final class MceChestScreenHandler extends GenericContainerScreenHandler {
    public MceChestScreenHandler(int syncId, PlayerInventory playerInventory, Inventory inventory) {
        super(ScreenHandlerType.GENERIC_9X3, syncId, playerInventory, inventory, MceChestGui.ROWS);
    }

    @Override
    public void onSlotClick(int slotIndex, int button, SlotActionType actionType, PlayerEntity player) {
        if (slotIndex >= 0 && slotIndex < MceChestGui.SIZE) {
            if (player instanceof ServerPlayerEntity serverPlayer) {
                handleTopSlotClick(slotIndex, serverPlayer);
            }
            return;
        }

        super.onSlotClick(slotIndex, button, actionType, player);
    }

    @Override
    public ItemStack quickMove(PlayerEntity player, int slot) {
        if (slot >= 0 && slot < MceChestGui.SIZE) {
            return ItemStack.EMPTY;
        }
        return ItemStack.EMPTY;
    }

    @Override
    public boolean canUse(PlayerEntity player) {
        return true;
    }

    private void handleTopSlotClick(int slotIndex, ServerPlayerEntity player) {
        MceGuiAction action = MceGuiAction.bySlot(slotIndex);
        if (action == null) {
            return;
        }

        if (player.getItemCooldownManager().isCoolingDown(action.cooldownItem)) {
            player.sendMessage(Text.translatable("marker_command_engine.cooldown.active"), true);
            return;
        }

        player.getItemCooldownManager().set(action.cooldownItem, MceItems.COOLDOWN_TICKS);
        MceCommandExecutor.run(player, action.command);
        player.sendMessage(Text.translatable("marker_command_engine.chest.feedback.executed", Text.translatable(action.titleKey), MceItems.COOLDOWN_SECONDS), true);
    }
}
