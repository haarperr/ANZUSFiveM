<script lang="ts">

export let text = 'www.anzus.life - discord.gg/anzus';
</script>

<style>
    .watermark {
       
        font-family: system-ui, sans-serif;
        font-size: 16px;
        letter-spacing: 1px;
        word-spacing: 2px;
        color: #ffffff;
        font-weight: 700;
        text-decoration: none solid rgb(68, 68, 68);
        font-style: normal;
        font-variant: small-caps;
        text-shadow: 0 0 0.2em #000, 0 0 0.2em #000;
        text-transform: uppercase;
        position: absolute;
        bottom: 0;
        width: 100%;
        text-align: center;
    }


    @media (min-width: 800px) {
    .watermark {
      left: 2.5vh!important;
      bottom: 1%!important;
    }
  }

  @media (width: 3840px) and (height: 2160px) {
    .watermark {
      left: 2.4vh!important;
      bottom: 6.1%!important;
      width: 29.3vh!important;
    }
  }


  @media (width: 3440px) and (height: 1440px) {
    .watermark {
      left: 2.3vh!important;
      bottom: 6.1%!important;
      width: 29.3vh!important;
    }

  }


  @media (width: 2560px) and (height: 1440px) {
    .watermark {
      left: 0.2vw!important;
      bottom: -1.8vh!important;
    }

  }

  @media (width: 2560px) and (height: 1080px) {
    .watermark {
        left: -0.25vw !important;
        bottom: -1.8vh !important;
    }

}

  @media (width: 1920px) and (height: 1440px) {
    .watermark {
      left: 0vw!important;
      bottom: -1.9vh!important;
    }

  }

  @media (width: 1920px) and (height: 1200px) {
    .watermark {
      left: 0.1vw!important;
      bottom: -2vh!important;
    }

  }

  @media (width: 1920px) and (height: 1080px) {
    .watermark {
      left: 0.1vw!important;
      bottom: -2vh!important;
    }

  }

  @media (width: 1280px) and (height: 720px) {
    .watermark {
      left: 0.1vw!important;
      bottom: -2vh!important;
    }
  }

</style>

<div class="watermark">{text}</div>