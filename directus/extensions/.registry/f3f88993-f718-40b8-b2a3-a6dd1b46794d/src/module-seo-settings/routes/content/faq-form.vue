<template>
    <private-view smallHeader :title="isEdit ? 'Edit FAQ' : 'Create FAQ'">
        <template #title>
            <div>
                <h1 class="font-semibold text-lg text-slate-900">{{ isEdit ? 'Edit FAQ' : 'Create FAQ' }}</h1>
                <div class="text-sm">{{ isEdit ? 'Modify FAQ details' : 'Add a new frequently asked question' }}</div>
            </div>
        </template>
        <template #actions>
            <v-button
                v-tooltip.bottom="Save"
                @click="onSave"
                rounded
                icon
                :disabled="saving || loading"
                :loading="saving"
            >
                <v-icon name="check"></v-icon>
            </v-button>
        </template>
        <template #navigation>
            <navigator />
        </template>
        <div class="py-6 px-7.5 max-w-3xl">
            <div class="grid gap-6">
                <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                    <div class="space-y-4">
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Category</label>
                            <select 
                                v-model="formData.category"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 bg-white"
                            >
                                <option value="">Select category</option>
                                <option value="product">Product</option>
                                <option value="shipping">Shipping</option>
                                <option value="payment">Payment</option>
                                <option value="return">Return Policy</option>
                                <option value="general">General</option>
                            </select>
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Question (English)</label>
                            <input 
                                v-model="formData.question" 
                                type="text" 
                                placeholder="Enter the question"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Question (Chinese)</label>
                            <input 
                                v-model="formData.question_en" 
                                type="text" 
                                placeholder="中文问题"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Answer (English)</label>
                            <textarea 
                                v-model="formData.answer" 
                                rows="4"
                                placeholder="Enter the answer"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 resize-none"
                            ></textarea>
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Answer (Chinese)</label>
                            <textarea 
                                v-model="formData.answer_en" 
                                rows="4"
                                placeholder="中文答案"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 resize-none"
                            ></textarea>
                        </div>
                        <div class="space-y-2">
                            <label class="block text-sm font-medium text-slate-700">Sort Order</label>
                            <input 
                                v-model.number="formData.sort" 
                                type="number" 
                                min="0"
                                placeholder="0"
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 w-24"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </private-view>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { useApi, useStores } from '@directus/extensions-sdk';
import Navigator from '../../components/navigator/index.vue';

const route = useRoute();
const router = useRouter();
const api = useApi();
const { useNotificationsStore } = useStores();
const notify = useNotificationsStore();

const isEdit = computed(() => !!route.params.id);
const loading = ref(false);
const saving = ref(false);

const formData = reactive({
    question: '',
    question_en: '',
    answer: '',
    answer_en: '',
    category: '',
    sort: 0
});

async function loadFaq() {
    if (!isEdit.value) return;
    
    loading.value = true;
    try {
        const response = await api.get(`/items/faqs/${route.params.id}`);
        const data = response.data.data;
        formData.question = data.question || '';
        formData.question_en = data.question_en || '';
        formData.answer = data.answer || '';
        formData.answer_en = data.answer_en || '';
        formData.category = data.category || '';
        formData.sort = data.sort || 0;
    } catch (error) {
        console.error('Failed to load FAQ:', error);
        notify.add({ title: 'Error loading FAQ', type: 'error' });
    }
    loading.value = false;
}

async function onSave() {
    saving.value = true;
    try {
        if (isEdit.value) {
            await api.patch(`/items/faqs/${route.params.id}`, formData);
            notify.add({ title: 'FAQ updated successfully' });
        } else {
            await api.post('/items/faqs', formData);
            notify.add({ title: 'FAQ created successfully' });
        }
        
        router.push('/seo-settings/content/faqs');
    } catch (error) {
        console.error('Failed to save FAQ:', error);
        notify.add({ title: 'Error saving FAQ', type: 'error' });
    }
    saving.value = false;
}

onMounted(() => {
    loadFaq();
});
</script>