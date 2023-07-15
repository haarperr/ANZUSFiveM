<script lang="ts">
    import Watermark from './atoms/watermark.svelte'
    import MenuStore from '../stores/menuStore';
    
</script>



{#if $MenuStore.isMarkChecked}
 <Watermark text="www.anzus.life - discord.gg/anzus" />
{/if}


